# mattermost-backup

Mattermost messenger server beckup script

## Installation

Clone the repository and create a `backup_mattermost.conf` file.

```bash
git clone https://github.com/avtomon/mattermost-backup.git && cd gitlab-mattermost-backup && cp backup_mattermost.conf.sample backup_mattermost.conf
```

## Configuration

See: [backup_mattermost.conf.sample](backup_mattermost.conf.sample)

## Usage

Just execute the script:

```bash
./backup_mattermost.sh
```

## Setup cron job

Run the backup everyday at 2:00 am everyday.

```bash
crontab -e
```

and add following line:

```bash
0 2 * * * /path/to/backup_mattermost/backup_mattermost.sh
```
