class User:
    def __init__(self,id,password):
        self.id = id
        self.password = password

    def verify_crednetial(self,id,password):
        return self.id==id and self.password==password