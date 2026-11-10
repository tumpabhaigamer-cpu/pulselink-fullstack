CREATE TABLE "analytics_events" (
	"event_id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"profile_id" uuid NOT NULL,
	"event_type" text NOT NULL,
	"link_id" uuid,
	"visitor_hash" text,
	"referrer_domain" text,
	"utm_source" text,
	"utm_medium" text,
	"utm_campaign" text,
	"device_os" text,
	"country_code" text,
	"city" text,
	"duration_seconds" integer,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "crm_subscribers" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"profile_id" uuid NOT NULL,
	"source_link_id" uuid,
	"email" text,
	"phone_whatsapp" text,
	"full_name" text,
	"custom_fields" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"ip_country" text,
	"synced_to_integrations" boolean DEFAULT false NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "instagram_automations" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"profile_id" uuid NOT NULL,
	"scope" text DEFAULT 'ALL' NOT NULL,
	"media_id" text,
	"next_media_id" text,
	"trigger_type" text DEFAULT 'KEYWORD' NOT NULL,
	"keyword" text DEFAULT 'LINK' NOT NULL,
	"message" text DEFAULT 'Thanks for reaching out! Here’s the link: {link}' NOT NULL,
	"enabled" boolean DEFAULT false NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "instagram_automations_profile_id_unique" UNIQUE("profile_id")
);
--> statement-breakpoint
CREATE TABLE "instagram_deliveries" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"automation_id" uuid NOT NULL,
	"comment_id" text NOT NULL,
	"status" text DEFAULT 'PROCESSING' NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "instagram_deliveries_comment_id_unique" UNIQUE("comment_id")
);
--> statement-breakpoint
CREATE TABLE "links" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"profile_id" uuid NOT NULL,
	"type" text DEFAULT 'CLASSIC_LINK' NOT NULL,
	"title" text NOT NULL,
	"url" text,
	"thumbnail_url" text,
	"position" integer DEFAULT 0 NOT NULL,
	"parent_id" uuid,
	"is_archived" boolean DEFAULT false NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"is_pinned" boolean DEFAULT false NOT NULL,
	"is_spotlight" boolean DEFAULT false NOT NULL,
	"animation" text,
	"layout_size" text DEFAULT 'STANDARD' NOT NULL,
	"schedule_start" timestamp with time zone,
	"schedule_end" timestamp with time zone,
	"lock_config" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"routing_rules" jsonb DEFAULT '[]'::jsonb NOT NULL,
	"context_payload" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "orders_and_bookings" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"profile_id" uuid NOT NULL,
	"product_id" uuid,
	"buyer_name" text,
	"buyer_email" text,
	"buyer_phone" text,
	"amount_total" integer DEFAULT 0 NOT NULL,
	"platform_fee_amount" integer DEFAULT 0 NOT NULL,
	"creator_payout_amount" integer DEFAULT 0 NOT NULL,
	"payment_gateway" text,
	"payment_status" text DEFAULT 'PENDING' NOT NULL,
	"booked_slot_utc" timestamp with time zone,
	"meeting_url" text,
	"download_token" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "products_and_services" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"profile_id" uuid NOT NULL,
	"link_id" uuid,
	"product_type" text NOT NULL,
	"title" text NOT NULL,
	"price_minor" integer DEFAULT 0 NOT NULL,
	"currency" varchar(3) DEFAULT 'USD' NOT NULL,
	"discount_codes" jsonb DEFAULT '[]'::jsonb NOT NULL,
	"file_storage_key" text,
	"calendar_availability" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"platform_fee_bps" integer DEFAULT 1200 NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "profiles" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" uuid NOT NULL,
	"username" varchar(40) NOT NULL,
	"custom_domain" text,
	"tier" text DEFAULT 'FREE' NOT NULL,
	"display_name" varchar(100) NOT NULL,
	"bio" text DEFAULT '' NOT NULL,
	"avatar_url" text,
	"cover_url" text,
	"shop_enabled" boolean DEFAULT false NOT NULL,
	"header_video_url" text,
	"theme_config" jsonb NOT NULL,
	"social_links" jsonb DEFAULT '[]'::jsonb NOT NULL,
	"seo_config" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"pixels_config" jsonb DEFAULT '{}'::jsonb NOT NULL,
	"redirect_url" text,
	"redirect_until" timestamp with time zone,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "profiles_username_unique" UNIQUE("username"),
	CONSTRAINT "profiles_custom_domain_unique" UNIQUE("custom_domain")
);
--> statement-breakpoint
CREATE TABLE "pulse_demo_leads" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"demo_slug" text NOT NULL,
	"full_name" text NOT NULL,
	"email" text,
	"phone" text,
	"interest" text,
	"message" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "team_members" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"profile_id" uuid NOT NULL,
	"user_id" uuid NOT NULL,
	"role" text DEFAULT 'EDITOR' NOT NULL,
	"invited_at" timestamp with time zone DEFAULT now() NOT NULL,
	"accepted_at" timestamp with time zone
);
--> statement-breakpoint
CREATE TABLE "users" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"email" varchar(320) NOT NULL,
	"password_hash" text,
	"oauth_provider" text,
	"mfa_secret" text,
	"stripe_customer_id" text,
	"razorpay_account_id" text,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "users_email_unique" UNIQUE("email")
);
--> statement-breakpoint
CREATE TABLE "youtube_connections" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"profile_id" uuid NOT NULL,
	"channel_id" text NOT NULL,
	"channel_title" text NOT NULL,
	"thumbnail_url" text,
	"encrypted_access_token" text NOT NULL,
	"encrypted_refresh_token" text NOT NULL,
	"expires_at" timestamp with time zone NOT NULL,
	"created_at" timestamp with time zone DEFAULT now() NOT NULL,
	"updated_at" timestamp with time zone DEFAULT now() NOT NULL,
	CONSTRAINT "youtube_connections_profile_id_unique" UNIQUE("profile_id")
);
--> statement-breakpoint
ALTER TABLE "analytics_events" ADD CONSTRAINT "analytics_events_profile_id_profiles_id_fk" FOREIGN KEY ("profile_id") REFERENCES "public"."profiles"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "analytics_events" ADD CONSTRAINT "analytics_events_link_id_links_id_fk" FOREIGN KEY ("link_id") REFERENCES "public"."links"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "crm_subscribers" ADD CONSTRAINT "crm_subscribers_profile_id_profiles_id_fk" FOREIGN KEY ("profile_id") REFERENCES "public"."profiles"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "crm_subscribers" ADD CONSTRAINT "crm_subscribers_source_link_id_links_id_fk" FOREIGN KEY ("source_link_id") REFERENCES "public"."links"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "instagram_automations" ADD CONSTRAINT "instagram_automations_profile_id_profiles_id_fk" FOREIGN KEY ("profile_id") REFERENCES "public"."profiles"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "instagram_deliveries" ADD CONSTRAINT "instagram_deliveries_automation_id_instagram_automations_id_fk" FOREIGN KEY ("automation_id") REFERENCES "public"."instagram_automations"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "links" ADD CONSTRAINT "links_profile_id_profiles_id_fk" FOREIGN KEY ("profile_id") REFERENCES "public"."profiles"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "links" ADD CONSTRAINT "links_parent_id_links_id_fk" FOREIGN KEY ("parent_id") REFERENCES "public"."links"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "orders_and_bookings" ADD CONSTRAINT "orders_and_bookings_profile_id_profiles_id_fk" FOREIGN KEY ("profile_id") REFERENCES "public"."profiles"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "orders_and_bookings" ADD CONSTRAINT "orders_and_bookings_product_id_products_and_services_id_fk" FOREIGN KEY ("product_id") REFERENCES "public"."products_and_services"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "products_and_services" ADD CONSTRAINT "products_and_services_profile_id_profiles_id_fk" FOREIGN KEY ("profile_id") REFERENCES "public"."profiles"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "products_and_services" ADD CONSTRAINT "products_and_services_link_id_links_id_fk" FOREIGN KEY ("link_id") REFERENCES "public"."links"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "profiles" ADD CONSTRAINT "profiles_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "team_members" ADD CONSTRAINT "team_members_profile_id_profiles_id_fk" FOREIGN KEY ("profile_id") REFERENCES "public"."profiles"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "team_members" ADD CONSTRAINT "team_members_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "youtube_connections" ADD CONSTRAINT "youtube_connections_profile_id_profiles_id_fk" FOREIGN KEY ("profile_id") REFERENCES "public"."profiles"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "analytics_profile_created_idx" ON "analytics_events" USING btree ("profile_id","created_at");--> statement-breakpoint
CREATE INDEX "subscribers_profile_idx" ON "crm_subscribers" USING btree ("profile_id");--> statement-breakpoint
CREATE INDEX "links_profile_position_idx" ON "links" USING btree ("profile_id","position");--> statement-breakpoint
CREATE UNIQUE INDEX "team_profile_user_idx" ON "team_members" USING btree ("profile_id","user_id");