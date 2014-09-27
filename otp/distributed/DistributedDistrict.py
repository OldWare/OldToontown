# File: D (Python 2.4)

from direct.directnotify.DirectNotifyGlobal import directNotify
from direct.distributed.DistributedObject import DistributedObject

class DistributedDistrict(DistributedObject):
    notify = directNotify.newCategory('DistributedDistrict')
    neverDisable = 1
    
    def __init__(self, cr):
        DistributedObject.__init__(self, cr)
        self.name = 'NotGiven'
        self.available = 0
        self.avatarCount = 0
        self.newAvatarCount = 0

    
    def announceGenerate(self):
        DistributedObject.announceGenerate(self)
        self.cr.activeDistrictMap[self.doId] = self
        messenger.send('shardInfoUpdated')

    
    def delete(self):
        if base.cr.distributedDistrict is self:
            base.cr.distributedDistrict = None
        
        if self.cr.activeDistrictMap.has_key(self.doId):
            del self.cr.activeDistrictMap[self.doId]
        
        DistributedObject.delete(self)
        messenger.send('shardInfoUpdated')

    
    def setAvailable(self, available):
        self.available = available
        messenger.send('shardInfoUpdated')

    
    def setName(self, name):
        self.name = name
        messenger.send('shardInfoUpdated')


