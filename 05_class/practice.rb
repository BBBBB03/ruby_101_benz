# Class User
class User
    attr_accessor :name, :email, :password
  
    def initialize(name, email, password)
      @name = name
      @email = email
      @password = password
      @rooms = []  # เก็บห้องที่ผู้ใช้เข้าร่วม
    end
  
    # Method ให้ผู้ใช้เข้าห้อง
    def enter_room(room)
      room.add_user(self) unless @rooms.include?(room)
      @rooms << room
    end
  
    # Method ให้ผู้ใช้ส่งข้อความในห้อง
    def send_message(room, content)
      if @rooms.include?(room)
        message = Message.new(self, room, content)
        room.broadcast(message)
      else
        puts "#{name} is not a member of this room."
      end
    end
  
    # Method ยืนยันการรับข้อความ
    def acknowledge_message(room, message)
      if @rooms.include?(room)
        puts "#{name} received: #{message.content}"
      else
        puts "#{name} is not a member of this room."
      end
    end
  end
  
  # Class Room
  class Room
    attr_accessor :name, :description, :users
  
    def initialize(name, description)
      @name = name
      @description = description
      @users = []
    end
  
    # Method เพิ่มผู้ใช้ในห้อง
    def add_user(user)
      @users << user unless @users.include?(user)
    end
  
    # Method กระจายข้อความให้ทุกคนในห้อง
    def broadcast(message)
      @users.each do |user|
        user.acknowledge_message(self, message)
      end
    end
  end
  
  # Class Message
  class Message
    attr_accessor :user, :room, :content
  
    def initialize(user, room, content)
      @user = user
      @room = room
      @content = content
    end
  end
  
  # ทดสอบการทำงานของโปรแกรม
  # สร้างผู้ใช้ใหม่
  user1 = User.new("Alice", "alice@example.com", "password123")
  user2 = User.new("Bob", "bob@example.com", "password456")
  
  # สร้างห้องใหม่
  room = Room.new("Ruby Room", "A place to discuss Ruby programming")
  
  # ให้ผู้ใช้เข้าร่วมในห้อง
  user1.enter_room(room)
  user2.enter_room(room)
  
  # ให้ผู้ใช้ส่งข้อความ
  user1.send_message(room, "Hello, Ruby enthusiasts!")
  user2.send_message(room, "Hi Alice!")
  