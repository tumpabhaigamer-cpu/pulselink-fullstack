# PulseLink Full-Stack

Full-stack Next.js creator page and link-in-bio studio from the supplied architecture ZIP.

## Included

- Creator studio with profile, design, templates, and phone preview
- Public profile routes with link and content widgets
- PostgreSQL data model managed by Drizzle migrations
- API routes for links, analytics, leads, audience, widget data, YouTube, and Instagram flows
- Demo pages for service-business and creator experiences
- Original source ZIP at `archives/linktree-system-architecture-breakdown.zip`

## Run locally

1. Install Node.js 20 or newer and PostgreSQL 15 or newer.
2. Install dependencies and prepare local settings:

   ```sh
   npm install
   Copy-Item .env.example .env
   ```

3. Set `DATABASE_URL` in `.env` to your PostgreSQL connection string.
4. Create/update the local database schema and start the app:

   ```sh
   npm run db:migrate
   npm run dev
   ```

Open <http://localhost:3000>. The app requires PostgreSQL for the dashboard and data APIs. YouTube and Instagram OAuth/webhooks need the corresponding provider credentials in `.env`; those integrations remain unavailable until configured.

## Deploy

The repo includes `railway.json` for a Node.js host: it builds the Next.js app, applies Drizzle migrations before startup, and checks `/api/health`. Configure `DATABASE_URL` and `APP_BASE_URL` in the host environment. Add provider variables from `.env.example` only when you configure those integrations. Never commit `.env` or production credentials.

GitHub Pages can only serve the static project overview at the root; it cannot run this app's API routes or PostgreSQL integration.
