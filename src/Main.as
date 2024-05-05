uint lastCheck = 0;
uint hornReactivationTime = 0;
bool timeoutActive = false;
bool HornCurrentlyDisabled = false;


/** Called every frame. `dt` is the delta time (milliseconds since last frame).
*/
/*
void Update(float dt) {
    if (S_Demo) {
        ToggleOnOffRepeatedly();
    } else {
        CheckHornReEnable();
    }
}
*/
/*
void CheckHornReEnable() {
    if (timeoutActive && Time::Now > hornReactivationTime) {
        timeoutActive = false;
        SetHornsEnabled();
    }
}

void ToggleOnOffRepeatedly() {
    if (Time::Now > lastCheck + 250) {
        lastCheck = Time::Now;
        timeoutActive = !timeoutActive;
        if (timeoutActive) SetHornsDisabled();
        else SetHornsEnabled();
    }
}

void OnActivateTimeout() {
    hornReactivationTime = Time::Now + S_TimeoutLength * 1000;
    timeoutActive = true;
    startnew(SetHornsDisabled);
}


void Main()
{
   print("Hello world!");
}
*/
void SetHornsDisabled() {
    try {
        cast<CTrackManiaNetworkServerInfo>(cast<CGameManiaPlanet>(GetApp()).Network.ServerInfo).DisableHorns = true;
        HornCurrentlyDisabled = true;
    } catch {
        NotifyWarning("Exception while disabling horns: " + getExceptionInfo());
    }
}

void SetHornsEnabled() {
    try {
        cast<CTrackManiaNetworkServerInfo>(cast<CGameManiaPlanet>(GetApp()).Network.ServerInfo).DisableHorns = false;
        HornCurrentlyDisabled = false;
    } catch {
        NotifyWarning("Exception while enabling horns: " + getExceptionInfo());
    }
}

void Notify(const string &in msg) {
    UI::ShowNotification(Meta::ExecutingPlugin().Name, msg);
    trace("Notified: " + msg);
}

void NotifyError(const string &in msg) {
    warn(msg);
    UI::ShowNotification(Meta::ExecutingPlugin().Name + ": Error", msg, vec4(.9, .3, .1, .3), 5000);
}

void NotifyWarning(const string &in msg) {
    warn(msg);
    UI::ShowNotification(Meta::ExecutingPlugin().Name + ": Warning", msg, vec4(.9, .6, .2, .3), 5000);
}

void NotifyInfo(const string &in msg) {
    trace("[INFO] " + msg);
    UI::ShowNotification(Meta::ExecutingPlugin().Name, msg, vec4(.1, .5, .9, .3), 5000);
}

/** Called whenever a key is pressed on the keyboard. See the documentation for the [`VirtualKey` enum](https://openplanet.dev/docs/api/global/VirtualKey). */
UI::InputBlocking OnKeyPress(bool down, VirtualKey key) {
    // Only run once every second, to avoid user holding down key to continuously toggle horn
    if (down && key == 190) {
        if (Time::Now > lastCheck + 1000) {
            //NotifyInfo("Current Time:" + Time::Now + " Last Checked:" + lastCheck);
            lastCheck = Time::Now;
            if (HornCurrentlyDisabled) {
                NotifyInfo("HORN ENABLED");
                print("HORN ENABLED");
                SetHornsEnabled();
            }
            else {
                NotifyInfo("HORN DISABLED");
                print("HORN DISABLED");
                SetHornsDisabled();
            }
        }
    }
    return UI::InputBlocking::DoNothing;
}
