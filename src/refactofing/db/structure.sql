CREATE TABLE "articles" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(255) NOT NULL, "annotation" text NOT NULL, "content" text NOT NULL, "user_id" integer NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "articles_recipes" ("article_id" integer, "recipe_id" integer);
CREATE TABLE "comments" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "content" text NOT NULL, "user_id" integer NOT NULL, "comment_type" integer NOT NULL, "recipe_id" integer, "ingredience_id" integer, "article_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "ingredience_categories" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255) NOT NULL, "description" text NOT NULL, "category_type" integer DEFAULT 0 NOT NULL, "user_id" integer NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "ingredience_categories_ingrediences" ("ingredience_category_id" integer, "ingredience_id" integer);
CREATE TABLE "ingredience_recipe_connectors" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "ingredience_id" integer, "recipe_id" integer, "quantity" float DEFAULT 1 NOT NULL, "importance" integer DEFAULT 1 NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "ingrediences" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255) NOT NULL, "annotation" text NOT NULL, "content" text NOT NULL, "avaliability" integer DEFAULT 1 NOT NULL, "units" varchar(255) NOT NULL, "user_id" integer NOT NULL, "activation_state" integer DEFAULT 0 NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "marks" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "recipe_id" integer, "value" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "recipe_categories" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255) NOT NULL, "description" text NOT NULL, "category_type" integer DEFAULT 0 NOT NULL, "user_id" integer NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "recipe_categories_recipes" ("recipe_category_id" integer, "recipe_id" integer);
CREATE TABLE "recipe_recipe_connectors" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "recipe_id" integer NOT NULL, "subrecipe_id" integer NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "recipes" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255) NOT NULL, "annotation" text NOT NULL, "content" text NOT NULL, "level" integer DEFAULT 0 NOT NULL, "estimated_time" integer DEFAULT 60 NOT NULL, "user_id" integer NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "image" varchar(255));
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "username" varchar(255) NOT NULL, "email" varchar(255) NOT NULL, "crypted_password" varchar(255) NOT NULL, "salt" varchar(255), "self_ruleset" integer DEFAULT 0 NOT NULL, "others_ruleset" integer DEFAULT 0 NOT NULL, "first_name" varchar(255), "second_name" varchar(255), "age" varchar(255), "note" text, "active" boolean DEFAULT 't' NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "activation_state" varchar(255) DEFAULT NULL, "activation_token" varchar(255) DEFAULT NULL, "activation_token_expires_at" datetime DEFAULT NULL);
CREATE INDEX "index_articles_on_user_id" ON "articles" ("user_id");
CREATE INDEX "index_articles_recipes_on_article_id_and_recipe_id" ON "articles_recipes" ("article_id", "recipe_id");
CREATE INDEX "index_articles_recipes_on_recipe_id_and_article_id" ON "articles_recipes" ("recipe_id", "article_id");
CREATE INDEX "index_comments_on_article_id" ON "comments" ("article_id");
CREATE INDEX "index_comments_on_ingredience_id" ON "comments" ("ingredience_id");
CREATE INDEX "index_comments_on_recipe_id" ON "comments" ("recipe_id");
CREATE INDEX "index_comments_on_user_id" ON "comments" ("user_id");
CREATE INDEX "index_ingrediences_on_user_id" ON "ingrediences" ("user_id");
CREATE INDEX "index_marks_on_recipe_id" ON "marks" ("recipe_id");
CREATE INDEX "index_marks_on_user_id" ON "marks" ("user_id");
CREATE INDEX "index_recipe_recipe_connectors_on_recipe_id" ON "recipe_recipe_connectors" ("recipe_id");
CREATE INDEX "index_recipe_recipe_connectors_on_subrecipe_id" ON "recipe_recipe_connectors" ("subrecipe_id");
CREATE INDEX "index_recipes_on_user_id" ON "recipes" ("user_id");
CREATE INDEX "index_users_on_activation_token" ON "users" ("activation_token");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20121031122436');

INSERT INTO schema_migrations (version) VALUES ('20121118214321');

INSERT INTO schema_migrations (version) VALUES ('20121121135916');

INSERT INTO schema_migrations (version) VALUES ('20121121183220');

INSERT INTO schema_migrations (version) VALUES ('20121128202342');

INSERT INTO schema_migrations (version) VALUES ('20121128202438');

INSERT INTO schema_migrations (version) VALUES ('20121211220211');

INSERT INTO schema_migrations (version) VALUES ('20121211222855');

INSERT INTO schema_migrations (version) VALUES ('20121211223036');

INSERT INTO schema_migrations (version) VALUES ('20121211223609');

INSERT INTO schema_migrations (version) VALUES ('20121211223924');

INSERT INTO schema_migrations (version) VALUES ('20121211231401');

INSERT INTO schema_migrations (version) VALUES ('20121212143903');

INSERT INTO schema_migrations (version) VALUES ('20130101230700');

INSERT INTO schema_migrations (version) VALUES ('20130102001500');

INSERT INTO schema_migrations (version) VALUES ('20130102002000');