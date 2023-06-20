CarrierWave.configure do |config|
    config.fog_credentials = {
        provider:               'Google',
        google_project:         'my-project',
        google_json_key_string: '{
            "type": "service_account",
            "project_id": "my-closet-390405",
            "private_key_id": "0e2b4197e797a76ad508fe2a17f8e9d62d69c327",
            "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCwwWrUkBHgaKNM\nvHhDV9lTxPIYx9PCjKzUNx6X9yZecUtKkHzn4CFc5RcK7JLFAihWrYDkXefjGwXg\nuxGWMQMyI7HT0neIqDAXIu8rQS7M0I1BuM9ud8F0i9Q2APWNfIZMV52sg7QwIxie\n/9p67Tfa0TWx3WML9BWfOU8e13AtPWi6epQFs9emoh4Hf2oSGm8QM8HEXFcPxelS\nT7NO7HsdmJcggvqF+nrZR0oG4MBVI1f2OjACgy9VNuukajz+xJx2aDzbsbEjF3t/\nJqyQK9xDj0UGRfdHRaM4h2fEvm7caTN690+3oiA7aXroOH7jRgIIWHHfgtVu1IfV\n9us6ZSM/AgMBAAECggEAFedqLzxJUtd0wSor9yB4WKaz37lHtzjKpCPOgUOJ+DMv\nAucD65I9YC8tm1d02sApMpCew+4VMfIj2NUl2UhqnniI7XiMAp3hE8TrAZ+6xnvj\nvWzDG+vwR9qaKjUVOPrhA63p5rqNhlebEf0f3JLwFIhPkKKgRxdw5IHsGaTWDGz1\n8kKJAckEh+hMEJRX1p2Ub16pSDTvxWPlABEOXd+yci6bUaFbfqTEvQQJfLgtXW9g\nRF7y6SdM9Ec/f4qr0qP1KjVrapEUNIj1Yc8uzOM6i6J8J7T4/TP6kaT8dDLZsPXw\n0BQOJLsGneUlYO8rzcmQ9nItXkeksWV1h5Wokg2HaQKBgQD23xB8hN/omFNCBh9F\niu735l7RZsJg8PQcRJe/C238NQj7OM2+J36K1Xo+lBr7j5w/GdG5ePEU9qo/YWP2\nGGv9AC+BKUXdPGrB8T7RjMMneZU5UAV+T5mkr+dOqhO297P1jCZMSaGuL2Y/xKg0\nu3x7+MAztajtmGgUCgSK3SpbJwKBgQC3Sp8+eByIeOcTlM2ug4AJE7NpSQ70C6I1\nEzOVKosD7ph7ck0qFjKTVVZ6NLvGE4D1uQTEpNR3t5MwZ9YFrCYp2cdk/4W6ynE3\nHGE5hxKLgBsOHgQOS0BjSZzVH2q/17uZwPUJBAWaog+0biQyGyKwgQD6ZOPiCVNh\nJoRo2j1mKQKBgEhvCKpQXlYjo4Iiw7gm3JjV+gocyXmiGS3WHmQKmXm/oeP8NbnO\nYr2fh1+nGwemimSlUbjGuI27FhbEn4zMe5rfHBEcqAgSuwwumYzobTY+4T7QsNvv\nxRfiGM8m7ePoZ9/rAC2wCQVPmQOq0uOuAwdo5BQIAAm+hwMiMVUBMXVPAoGAJStC\nw75DuwEZiwT/+MW97xlJpq4kFCVPzYeJTFSGQFPgJBh3wXMi6nHByaJr+az2192f\nM+lhFK3rcUN9SUUxsAbzwm12xvxKnSxqIupbPmLKGcDIfcWQ1xGUdjuawDCVYIaa\nqitgn40Btksnl+mczUI72osfEzVk7SyMaV7oWJECgYEAioys/pPOUCUu/qqonMk+\nZstKpT4SYT5VI8QV5vEzJINyP9YpiSacxmnWHvp9dTKp+J1YPdp2Vvoo0624UhJF\nAtQPr67Hqn/IjjXJFQ+bZSFNwV/hX7pQ4vt5mymrSF2xjyO+lNxcfEaE9PLX4sR6\na0bxj1ZJelc+dWLEIrVkx8s=\n-----END PRIVATE KEY-----\n",
            "client_email": "my-closet-developer@my-closet-390405.iam.gserviceaccount.com",
            "client_id": "103778790515365367109",
            "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            "token_uri": "https://oauth2.googleapis.com/token",
            "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
            "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/my-closet-developer%40my-closet-390405.iam.gserviceaccount.com",
            "universe_domain": "googleapis.com"
          }'
    }
    config.fog_directory = 'google_cloud_storage_bucket_name'
end