import Vapor

func routes(_ app: Application) throws {
  app.get { req in
    return "AddaAPIGateway works!"
  }
  
  app.get("hello") { req -> String in
    return "Hello, world!"
  }
  
  try app.group("v1") { api in
    try api.register(collection: AuthController())
    
    // USERS
    let users = api.grouped("users")
    let usersAuth = users.grouped(JWTMiddleware())
    try usersAuth.register(collection: UsersController() )
    
    // CONTACTS
    let contacts = api.grouped("contacts")
    let contactsAuth = contacts.grouped(JWTMiddleware())
    try contactsAuth.register(collection: ContactsController() )
    
    // EVENTS
    let events = api.grouped("events")
    let eventsAuth = events.grouped(JWTMiddleware())
    try eventsAuth.register(collection: EventsController() )
    
    // MESSAGES
    let messages = api.grouped("messages")
    let messagesAuth = messages.grouped(JWTMiddleware())
    try messagesAuth.register(collection: MessageController() )
    
    // DEVICE
    let device = api.grouped("devices")
    let devicesAuth = device.grouped(JWTMiddleware())
    try devicesAuth.register(collection: DeviceController() )
    
    // CONVERSATIONS
    let conversations = api.grouped("conversations")
    let conversationsAuth = conversations.grouped(JWTMiddleware())
    try conversationsAuth.register(collection: ConversationController())
    
    // WEBSOCKET
    let chat = api.grouped("chat")
    let chatAuth = chat.grouped(JWTMiddleware())
    try chatAuth.register(collection: ChatController())
    
    // ATTACHMENTS
    let attachment = api.grouped("attachments")
    let attachmentsAuth = attachment.grouped(JWTMiddleware())
    try attachmentsAuth.register(collection: AttachmentController())
    
  }
}
