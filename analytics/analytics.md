Skip this step if you do not want the analytics script


The service account key is a JSON file that contains the credentials for authenticating your application to access Firebase services using the Firebase Admin SDK.

To obtain the service account key file, you need to follow these steps:

1. Go to the Firebase console (https://console.firebase.google.com/) and select your project.
2. Click on the gear icon in the top-left corner to open the project settings.
3. Navigate to the "Service Accounts" tab.
4. Scroll down to the section titled "Firebase Admin SDK" and click on the "Generate new private key" button.
5. A dialog box will appear with a warning about securely storing the service account key. Click on the "Generate key" button.
6. The service account key JSON file will be downloaded to your computer.
7. Make sure to keep the service account key file secure and do not share it publicly, as it provides access to your Firebase project and associated services.

Once you have the service account key file, you can use it to initialize the Firebase Admin SDK in your Python script as shown below.

```
import firebase_admin
from firebase_admin import credentials


cred = credentials.Certificate('keys/serviceAccountKey.json')
firebase_admin.initialize_app(cred)

```

Or, a much safer option:

```

import firebase_admin
from firebase_admin import credentials
import os

# Load service account key from environment variable
service_account_key = os.environ.get('FIREBASE_SERVICE_ACCOUNT_KEY')

# Initialize Firebase Admin SDK
cred = credentials.Certificate(service_account_key)
firebase_admin.initialize_app(cred)



```

NOTE: Never store your service account key in a public repository