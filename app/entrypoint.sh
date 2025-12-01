set -e

echo "🔹 Génération du client Prisma..."
npx prisma generate

echo "🔹 Application des migrations..."
npx prisma migrate deploy

echo "🔹 Seed de la base de données..."
ts-node prisma/seed.ts

echo "🔹 Démarrage de l'application..."
npm start
