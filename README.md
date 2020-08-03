# AddaAPIGateway
For Test this Vapor 4 Api Gateway
Please download this two Vapor 4 App
1. https://github.com/AddaMeSPB/AddaMeAuth (Database i used: MongoDB) < This for Auth i am using login via mobile number
2. https://github.com/AddaMeSPB/EventEngine (Database i used: MongoDB) < Event CURD

Before Run Apps you much need to setup this .env xcode edit schema Environment variables 
For API need
1. JWKS={}
2. AUTH_URL=""
3. EVENTS_URL=""

AddaMeAuth
0. TWILIO_ACCOUNT_ID AND TWILIO_ACCOUNT_SECRET for AddaMeAuth app only

For Rest of 
1. JWKS={}
2. MONGO_DB_DEV=""

## Routes you can always check routes
`swift run Run routes`            
+--------+-----------------------+
| GET    | /                     |
+--------+-----------------------+
| GET    | /hello                |
+--------+-----------------------+
| POST   | /v1/auth/login        |
+--------+-----------------------+
| POST   | /v1/auth/verify_sms   |
+--------+-----------------------+
| POST   | /v1/auth/refreshToken |
+--------+-----------------------+
| POST   | /v1/events            |
+--------+-----------------------+
| GET    | /v1/events            |
+--------+-----------------------+
| GET    | /v1/events/:events_id |
+--------+-----------------------+
| PUT    | /v1/events/:events_id |
+--------+-----------------------+
| DELETE | /v1/events/:events_id |
+--------+-----------------------+

