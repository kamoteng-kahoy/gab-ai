from transformers import AutoTokenizer, AutoModelForCausalLM, pipeline
from huggingface_hub import login

# Login with Hugging Face API token
login("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")  # Replace with your actual Hugging Face token

# Load the model and tokenizer from Hugging Face
tokenizer = AutoTokenizer.from_pretrained("meta-llama/Llama-3.2-1B-Instruct")
model = AutoModelForCausalLM.from_pretrained("meta-llama/Llama-3.2-1B-Instruct")

# Initialize the conversational pipeline
chatbot = pipeline("text-generation", model=model, tokenizer=tokenizer)

def generate_meal_plan(age, weight, height, trimester, dietary_preferences, health_conditions):
    # Define the prompt
    prompt = (
        f"Generate a personalized 7-day meal plan for a pregnant woman based on the following details:\n"
        f"Age: {age}, Weight: {weight} kg, Height: {height} cm, Trimester: {trimester}\n"
        f"Dietary Preferences: {', '.join(dietary_preferences)}\n"
        f"Health Conditions: {', '.join(health_conditions)}\n"
        f"The meal plan should include breakfast, lunch, snacks, and dinner for each day."
    )

    # Generate the meal plan
    response = chatbot(prompt, max_length=500, num_return_sequences=1)
    meal_plan = response[0]['generated_text']

    return meal_plan

# Example usage
age = 30
weight = 70
height = 165
trimester = "2nd"
dietary_preferences = ["vegetarian", "gluten-free"]
health_conditions = ["gestational diabetes"]

meal_plan = generate_meal_plan(age, weight, height, trimester, dietary_preferences, health_conditions)
print("Generated Meal Plan:\n", meal_plan)
