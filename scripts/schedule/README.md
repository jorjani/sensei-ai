# Scheduling Automated Reviews

Run your weekly review automatically every Saturday morning.

## macOS (launchd)

1. Copy and edit the template:
   ```bash
   cp scripts/schedule/launchd.plist.template ~/Library/LaunchAgents/com.ai-coach.weekly-review.plist
   ```

2. Edit the plist -- replace `YOUR_USERNAME` with your actual username and update paths.

3. Load it:
   ```bash
   launchctl load ~/Library/LaunchAgents/com.ai-coach.weekly-review.plist
   ```

4. (Optional) Wake your Mac before the scheduled time:
   ```bash
   sudo pmset repeat wakeorpoweron S 07:50:00
   ```

### Verify it's loaded
```bash
launchctl list | grep ai-coach
```

### Unload
```bash
launchctl unload ~/Library/LaunchAgents/com.ai-coach.weekly-review.plist
```

## Linux (cron)

Add to your crontab (`crontab -e`):

```cron
# Weekly review every Saturday at 8:00 AM
0 8 * * 6 /path/to/ai-coach/scripts/run-review.sh
```

Make sure `claude` is in your PATH. You may need to specify the full path:

```cron
0 8 * * 6 PATH="/usr/local/bin:$PATH" /path/to/ai-coach/scripts/run-review.sh
```

## Output

Reviews are saved to `results/YYYY-MM-DD-review.md`. The script skips if today's review already exists.
