Valk.util.hook_before("EventManager.add_event", function(original, self)
    if not self.valk_queues_added then
        self.valk_queues_added = true
        self.queues["valk_1"] = {}
        self.queues["valk_2"] = {}
        self.queues["valk_3"] = {}
    end
end)
