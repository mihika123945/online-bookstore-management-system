from pymongo import MongoClient
from dotenv import load_dotenv
from langchain.chat_models import ChatOpenAI
import os
import json

load_dotenv()

# Load env variables
MONGO_URI = os.getenv("MONGODB_URI")
OPENROUTER_KEY = os.getenv("API_KEY")

# MongoDB client
client = MongoClient(MONGO_URI)
collection = client["bookstore"]["customers"]

# LLM client (OpenRouter or OpenAI)
llm = ChatOpenAI(
    model="mistralai/mixtral-8x7b-instruct",
    temperature=0,
    openai_api_key=OPENROUTER_KEY,
    openai_api_base="https://openrouter.ai/api/v1"
)

def generate_prompt(user_question):
    return f"""
You are a MongoDB expert. The 'customers' collection has this structure:
- Each document may contain an "Orders" array
- Each "Order" contains an "OrderDetails" array
- Each "OrderDetail" includes: Title, Price, Quantity, Subtotal, Genre

Write a valid MongoDB aggregation pipeline in pure JSON array format
(no explanation, no markdown) to answer:
"{user_question}"
"""

def get_pipeline_from_llm(user_question):
    prompt = generate_prompt(user_question)
    return llm.predict(prompt).strip()

def run_pipeline(pipeline_str):
    try:
        pipeline = json.loads(pipeline_str)
        result = list(collection.aggregate(pipeline))
        return result, None
    except Exception as e:
        return None, str(e)
