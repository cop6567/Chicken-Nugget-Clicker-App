# Simple script used for analytics
# Requires manual run

import firebase_admin
from firebase_admin import credentials

cred = credentials.Certificate('keys/serviceAccountKey.json')
firebase_admin.initialize_app(cred)

from firebase_admin import analytics

# Retrieve user's data from firebase
def retrieve_user_data():
    users = analytics.get_all_users(start_date='2023-01-01', end_date='2023-06-01')
    for user in users:
        print('User ID:', user.user_id)
        print('First Access:', user.first_access)
        print('Last Access:', user.last_access)
        print('-----------------------------------')

 # Retrieve Event data
def retrieve_event_data():
    events = analytics.get_events(start_date='2023-01-01', end_date='2023-06-01')
    for event in events:
        print('Event Name:', event.name)
        print('Event Date:', event.date)
        print('Event User ID:', event.user_id)
        print('-----------------------------------')

retrieve_user_data()
retrieve_event_data()
