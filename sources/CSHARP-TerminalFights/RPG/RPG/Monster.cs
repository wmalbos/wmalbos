using System;

namespace RPG
{
    public class Monster : Character
    {
        public override bool IsPlayer { get; } = false;
        
        public Monster()
        {
            Name = "Monstre";
        }

        // Execute une attaque physique
        public override int AttackPhysics()
        {
            var random = new Random();
            return random.Next(10, 15);
        }

        // Execute une attaque magique
        public override int AttackMagics()
        {
            var random = new Random();
            return random.Next(10, 15);
        }

        // Execute une attaque de manière aléatoire
        public int AttackRandom()
        {
            var random = new Random();
            var number = random.Next(0, 10);

            return number < 5 ? AttackPhysics() : AttackMagics();
        }
    }
}