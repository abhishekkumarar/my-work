trigger accountStatusChange on Account (before update) {
    accountStatusChangeHandler.handleStatus(trigger.new, trigger.oldMap);
}