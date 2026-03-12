# Power_BI_Dashboard

> **Note:** This content belongs in the [PowerBI_Data_Analytics_Course](https://github.com/katkhess/PowerBI_Data_Analytics_Course) repository. This standalone repo was created by mistake. Follow the steps below to move it there.

## Moving this project into your PowerBI_Data_Analytics_Course codespace

### Option A — One-command script (recommended)

A ready-made script [`migrate.sh`](./migrate.sh) handles everything automatically.

**Inside your `PowerBI_Data_Analytics_Course` codespace terminal, run:**

```bash
# Download the script, review it, then execute it
curl -fsSL https://raw.githubusercontent.com/katkhess/Power_BI_Dashboard/main/migrate.sh -o migrate.sh
cat migrate.sh   # review before running
bash migrate.sh
```

The script will:
1. Detect that you are already inside the course repo.
2. Download the `Power_BI_Dashboard/` folder from this repo into your codespace.
3. Stage the new files with `git add`.

Then commit and push:

```bash
git commit -m "Add Power_BI_Dashboard project"
git push
```

---

### Option B — Manual steps

If you prefer to do it by hand, run these commands **inside your `PowerBI_Data_Analytics_Course` codespace terminal**:

```bash
# 1. Clone the dashboard repo into a temp folder
git clone --depth 1 https://github.com/katkhess/Power_BI_Dashboard.git /tmp/pbi_dashboard

# 2. Copy the project folder into the course repo
cp -r /tmp/pbi_dashboard/Power_BI_Dashboard ./Power_BI_Dashboard

# 3. Stage, commit and push
git add Power_BI_Dashboard/
git commit -m "Add Power_BI_Dashboard project"
git push
```

After that, the `Power_BI_Dashboard/` folder will be part of `PowerBI_Data_Analytics_Course` alongside any future projects.

---

## Project Contents

| File / Folder | Description |
|---------------|-------------|
| [`Power_BI_Dashboard/Data_Jobs_Dashboard.pbix`](./Power_BI_Dashboard/Data_Jobs_Dashboard.pbix) | Power BI report file |
| [`Power_BI_Dashboard/Images/`](./Power_BI_Dashboard/Images/) | Dashboard screenshots |
| [`Power_BI_Dashboard/README.md`](./Power_BI_Dashboard/README.md) | Project documentation |
