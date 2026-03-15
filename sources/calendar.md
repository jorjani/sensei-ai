# Source: Calendar

Shows where time went: meetings vs focus blocks, recurring commitments, and time allocation by category.

## Config Keys

```yaml
sources:
  calendar:
    enabled: true
    days: 7
    # ics_file: ~/calendar-export.ics   # Optional: use a manual .ics export
```

## How to Gather

**Option 1: macOS with icalBuddy (preferred)**

Check if `icalBuddy` is available:
```bash
command -v icalBuddy
```

If available, pull events from the last N days:
```bash
icalBuddy -n -nc -nrd -df "%Y-%m-%d" -tf "%H:%M" -b "- " -iep "title,datetime,duration,calendar" eventsFrom:"today-7d" to:"today"
```

**Option 2: .ics file export**

If `ics_file` is set in config, read the file and parse VEVENT entries. Extract:
- SUMMARY (event title)
- DTSTART / DTEND (date, time, duration)
- CATEGORIES (if present)

**Option 3: No calendar available**

If neither icalBuddy nor ics_file is available, note: "Calendar source enabled but no calendar data found. Install icalBuddy (`brew install ical-buddy`) or set `ics_file` in config to an .ics export."

## How to Present

Categorize events and calculate time:

```
### Calendar (last 7 days)

**Time in meetings:** ~12h (28% of work hours)
**Focus time:** ~30h (72%)

**By category:**
- Customer calls: 4h (3 meetings)
- Internal syncs: 5h (5 meetings)
- 1:1s: 2h (2 meetings)
- Ad-hoc: 1h (1 meeting)

**Recurring commitments:**
- Monday standup (30 min)
- Wednesday all-hands (1h)
- Friday retro (45 min)
```

If event titles contain customer/prospect names, flag those for the coach's customer conversation analysis. Assume 40h work week for percentage calculations.
