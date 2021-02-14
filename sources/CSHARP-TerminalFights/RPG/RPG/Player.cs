using System;

namespace RPG
{
    public class Player : Character
    {
        public int NumberOfPotions = 3;

        public override bool IsPlayer { get; } = true;

        public Player(string name)
        {
            if (name == "")
            {
                throw new Exception("Le nom du joueur ne peu pas être vide");
            }

            Name = name;
        }

        // Execute une attauque physique
        public override int AttackPhysics()
        {
            var random = new Random();
            return random.Next(10, 15);
        }

        // Execute une attaque magique
        public override int AttackMagics()
        {
            var random = new Random();
            return random.Next(0, 25);
        }

        // Utilise une des potions pour restaurer les points de vie
        public void UsePotion()
        {
            if (NumberOfPotions > 0)
            {
                HealthPoints += 35;
                NumberOfPotions--;
            }
        }
    }
}