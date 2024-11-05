import pandas as pd
from sklearn.neighbors import NearestNeighbors
from datetime import datetime
import uuid
from flask import Flask, request, jsonify
from supabase import create_client, Client
import json
import os

# Supabase connection setup
SUPABASE_URL = 'https://qjuhnrwimxgvxvcpdtgh.supabase.co'
SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFqdWhucndpbXhndnh2Y3BkdGdoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjY0NTExMTAsImV4cCI6MjA0MjAyNzExMH0.NH0sm4ECUZlDOSI_C-8EjBc5A-o6lqHQ6g3DWoARreY'  # Replace with your actual anon key
supabase: Client = create_client(SUPABASE_URL, SUPABASE_ANON_KEY)

app = Flask(__name__)

# Load and preprocess the CSV data
try:
    # Adjust the file path as needed
    csv_path = os.path.join(os.getcwd(), 'lib', 'preg', 'meal plan', 'meal_recommendations.csv')
    meal_data = pd.read_csv(csv_path, encoding='ISO-8859-1')
    print("CSV loaded successfully.")
except FileNotFoundError as e:
    print(f"Error loading CSV file: {e}")
    meal_data = None

# Function to recommend meals based on user inputs and preferences
def recommend_meals(preferences, health_conditions):
    if meal_data is None:
        raise ValueError("Meal data could not be loaded.")
    
    filtered_meals = meal_data

    if preferences:
        # Log the preferences for debugging
        print(f"Filtering by preferences: {preferences}")
        # Filter meals that match dietary preferences (e.g., vegetarian, vegan, etc.)
        filtered_meals = filtered_meals[filtered_meals['Food'].apply(
            lambda food: any(p in food for p in preferences)
        )]
    
    print(f"Filtered meal count: {len(filtered_meals)}")

    # Select meals as recommendations (this example takes the first 28 meals for 7 days and 4 categories)
    recommended_meals = filtered_meals['Food'].head(28).tolist()

    # Log the recommended meals
    print(f"Recommended meals: {recommended_meals}")

    return recommended_meals

# Function to store meal plan into Supabase
def store_meal_plan(user_id, day, category, meal_items):
    try:
        meal_plan_id = str(uuid.uuid4())  # Generate a unique meal_plan_id
        created_at = datetime.now().isoformat()

        # Since meal_items is an ARRAY, pass it as a list directly (no need for json.dumps)
        data = {
            'meal_plan_id': meal_plan_id,
            'user_id': user_id,
            'created_at': created_at,
            'day_of_week': str(day),
            'category': category,
            'meal_items': meal_items  # Pass as a list since it matches Supabase ARRAY type
        }

        # Log the data to be inserted for debugging
        print(f"Data to be inserted: {data}")

        # Insert data into Supabase
        response = supabase.table('Meal_Plan').insert(data).execute()

        # Log the full Supabase response for debugging
        print(f"Supabase response: {response}")

        # Check for errors in the Supabase response
        if response.get('status_code') != 201 or 'error' in response:
            print(f"Supabase error: {response.get('error')}")
            return None

        print(f"Meal plan stored successfully: {response}")
        return response

    except Exception as e:
        print(f"Exception while storing meal plan: {e}")
        return None

# API Endpoint for 7-day meal plan generation
@app.route('/generate-meal-plan', methods=['POST'])
def generate_meal_plan():
    try:
        user_data = request.json

        # Log incoming request data for debugging
        print(f"Incoming data: {user_data}")

        # Fetch user inputs
        age = user_data.get('age')
        weight = user_data.get('weight')
        height = user_data.get('height')
        trimester = user_data.get('trimester')
        dietary_preferences = user_data.get('dietary_preferences', [])
        health_conditions = user_data.get('health_conditions', [])
        user_id = user_data.get('user_id')

        if not user_id:
            return jsonify({'status': 'error', 'message': 'Missing user_id'}), 400
        
        # Generate meal plan based on user's inputs and preferences
        meals = recommend_meals(dietary_preferences, health_conditions)
        
        # Check if meals are found
        if len(meals) < 28:
            return jsonify({'status': 'error', 'message': 'Not enough meals found for the given preferences/conditions'}), 404

        # Create a 7-day meal plan with 4 categories per day (breakfast, lunch, dinner, snacks)
        days_of_week = [1, 2, 3, 4, 5, 6, 7]
        categories = ['Breakfast', 'Lunch', 'Dinner', 'Snacks']

        meal_plan = {}
        for i, day in enumerate(days_of_week):
            meal_plan[day] = {}
            for j, category in enumerate(categories):
                meal_items = [meals[i * 4 + j]]
                meal_plan[day][category] = meal_items

                # Store each meal plan entry in Supabase
                response = store_meal_plan(user_id=user_id, day=day, category=category, meal_items=meal_items)
                if response is None:
                    return jsonify({'status': 'error', 'message': f'Failed to store meal plan for Day {day} - {category}'}), 500
        
        return jsonify({'status': 'Meal plan generated', 'meal_plan': meal_plan}), 200

    except Exception as e:
        print(f"Error generating meal plan: {e}")
        return jsonify({'status': 'error', 'message': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
