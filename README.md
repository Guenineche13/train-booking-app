# 🚆 Train Booking App

Bienvenue ! ✨  
Ce repository contient une application web de réservation de trains construite avec Next.js et TypeScript, utilisant Prisma pour la gestion de la base de données. Ce README décrit le projet, son scope, comment l'installer, le lancer en local, le builder pour la production, et les bonnes pratiques pour contribuer.

---

## 🧩 Présentation du projet

Train Booking App est une application moderne de réservation de billets de train :
- Frontend en Next.js + React (TypeScript)
- Gestion des données avec Prisma + PostgreSQL (ou autre DB supportée par Prisma)
- Authentification (NextAuth)
- Utilitaires et styles (TailwindCSS mentionné dans les dépendances)
- Scripts Prisma pour migration et seed

But : démontrer un workflow fullstack TypeScript/Next.js avec une couche persistante (Prisma), authentification et un set d'outils courants pour une application de réservation.

---

## 📂 Structure principale du dépôt

- /app — code applicatif (pages / routes / components)
- /lib — utilitaires réutilisables
- /prisma — schéma Prisma et seeder
- /public — assets statiques (images, icônes)
- Dockerfile — image Docker pour déploiement
- package.json — scripts et dépendances
- tsconfig.json — configuration TypeScript

---

## ⚙️ Prérequis

Avant d'installer et lancer le projet, assurez-vous d'avoir :
- Node.js (version recommandée : 18+ ou celle compatible avec Next.js 15)
- pnpm / npm / yarn (ici les scripts sont compatibles avec npm)
- Une base de données PostgreSQL (ou autre supportée par Prisma)
- (Optionnel) Docker si vous préférez conteneuriser

---

## 🔧 Installation (locale)

1. Clonez le dépôt
   ```
   git clone https://github.com/Guenineche13/train-booking-app.git
   cd train-booking-app
   ```

2. Installez les dépendances
   ```
   npm install
   ```
   (ou `pnpm install`, `yarn install` selon votre gestionnaire)

3. Créez un fichier d'environnement `.env.local` à la racine et ajoutez au minimum :
   ```
   DATABASE_URL="postgresql://user:password@localhost:5432/train_db?schema=public"
   # Ajoutez ici d'autres variables (ex: fournisseurs OAuth) si l'app les utilise
   ```

4. Initialisez la base de données (Prisma)
   - En développement :
     ```
     npx prisma migrate dev --name init
     npx prisma db seed
     ```
   - En production (ou pour reproduire le script présent dans package.json) :
     ```
     npx prisma migrate deploy
     npx prisma db seed
     ```

Note : Le package.json contient un script `prisma.seed` pointant vers `ts-node prisma/seed.ts`. Adaptez si nécessaire.

---

## ▶️ Scripts utiles (extraits de package.json)

- Développement :
  ```
  npm run dev
  ```
  (lance Next.js en mode développement)

- Build production :
  ```
  npm run build
  ```
  (par défaut le build exécute : `prisma migrate deploy && prisma generate && next build`)

- Post-build (seed DB) :
  ```
  npm run postbuild
  ```

- Démarrer la version buildée :
  ```
  npm start
  ```

- Lint (ESLint) :
  ```
  npm run lint
  ```

---

## 🗃️ Dépendances principales

(Extraits du package.json)
- runtime :
  - next (15.x)
  - react / react-dom (19.x)
  - @prisma/client
  - next-auth
  - bcrypt
- devDependencies :
  - prisma
  - typescript
  - ts-node
  - tailwindcss / postcss (présents dans la config)
  - eslint / eslint-config-next

---

## 🐘 Prisma — détails DB

- Le dossier `prisma/` contient le fichier `schema.prisma` et potentiellement un seeder `prisma/seed.ts`.
- Commandes Prisma utiles :
  - `npx prisma migrate dev --name <name>` (développement)
  - `npx prisma migrate deploy` (production)
  - `npx prisma generate` (génère le client)
  - `npx prisma db seed` (exécute le seeder défini)

---

## 🐳 Docker

Un Dockerfile est inclus pour construire une image de production. Exemple basique :
```
docker build -t train-booking-app .
docker run -e DATABASE_URL="..." -e NEXTAUTH_URL="..." -p 3000:3000 train-booking-app
```
Adaptez les variables d'environnement et volumes selon votre infra.

---

## 🔐 Authentification

Le projet mentionne NextAuth dans les dépendances. Variables fréquentes :
- NEXTAUTH_URL
- NEXTAUTH_SECRET
- (et selon les providers) GOOGLE_CLIENT_ID, GOOGLE_CLIENT_SECRET, etc.

Vérifiez la configuration dans le code (probablement sous /lib ou /app/api/auth).

---

## ✅ Checklist pour lancer l'app localement (récap rapide)

1. Installer Node.js et PostgreSQL
2. Cloner et installer dépendances
3. Créer `.env.local` avec DATABASE_URL + NEXTAUTH variables
4. Exécuter migrations/seeds (`npx prisma migrate dev` + `npx prisma db seed`)
5. Lancer `npm run dev`
6. Ouvrir http://localhost:3000

---

## 🚀 Déploiement

- Le build (`npm run build`) inclut les étapes Prisma (migrations / generate). Sur votre CI/CD, appliquez les migrations sur la DB de production avant de lancer l'image.
- Pour une stack containerisée : créer image Docker, pousser vers votre registry, déployer avec Kubernetes / Fly / Vercel / etc. (Vercel peut aussi déployer Next.js mais gérer Prisma/DB séparément).

---

## 🧪 Tests & qualité

- ESLint est configuré (`npm run lint`)
- Ajouter des tests unitaires / d'intégration (Jest/Testing Library) est fortement recommandé.

---

## 🤝 Contribution

Contributions bienvenues !  
- Ouvrez une issue pour discuter des changements majeurs
- Fork → branche → PR avec description claire
- Respectez la structure du projet et les conventions TypeScript/ESLint

---

Merci d'avoir regardé ce projet🚆✨
