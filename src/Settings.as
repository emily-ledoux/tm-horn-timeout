
[Setting name="Demo: toggle every .25s" description="Let's you test that it works provided you can find someone to honk a bunch. (Works for your horn, too)."]
bool S_Demo = false;

[Setting name="Timeout Length (s)" min="1" max="180"]
uint S_TimeoutLength = 30;

[Setting name="Shortcut Key" description="Default is 'Decimal' -- the period key on the num pad."]
VirtualKey S_ShortcutKey = VirtualKey::Decimal;

[Setting name="Show notifications on enable / disable?"]
bool S_ShowNotifications = true;
