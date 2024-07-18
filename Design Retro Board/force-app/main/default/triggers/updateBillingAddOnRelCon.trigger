trigger updateBillingAddOnRelCon on Account (after update) {
    updateBillingHandler.handleUpdate(trigger.new, trigger.oldMap);
}