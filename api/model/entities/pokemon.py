class Pokemon:
    def __init__(self,user,number,name,level,hp,id = None, species = None,type = None):
        self.id = id
        self.user = user
        self.number = number
        self.name = name
        self.species = species
        self.level = level
        self.hp = hp
        self.type = type
