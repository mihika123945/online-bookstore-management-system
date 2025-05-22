import streamlit as st
from utils import get_pipeline_from_llm, run_pipeline

st.set_page_config(page_title="MongoDB LLM Assistant", layout="wide")
st.title("📊 LLM-Powered MongoDB Business Assistant")
st.markdown("Ask any business question over your NoSQL customer/order/book data.")

user_input = st.text_input("💬 Ask a question:")

if user_input:
    with st.spinner("🔍 Generating aggregation pipeline..."):
        pipeline_str = get_pipeline_from_llm(user_input)

    st.subheader("🧱 MongoDB Aggregation Pipeline")
    st.code(pipeline_str, language="json")

    st.subheader("📈 Results")
    results, error = run_pipeline(pipeline_str)

    if error:
        st.error(f"❌ Error: {error}")
    elif results:
        st.dataframe(results)
    else:
        st.warning("⚠️ No results found.")
