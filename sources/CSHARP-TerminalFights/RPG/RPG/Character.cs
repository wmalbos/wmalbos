using System;

namespace RPG
{
    public abstract class Character
    {
        public string Name { get; set; }
        public int HealthPoints { get; set; } = 100;

        public abstract bool IsPlayer { get; }
        
        // Retourne si le charactère est toujours en vie
        public bool IsAlive()
        {
            return HealthPoints > 0;
        }

        // Le charactère reçoit des dégats
        public void TakeDamage(int damages)
        {
            if (damages < 0)
            {
                throw new Exception("Les dommages ne peuvent pas être négatifs");
            }

            // Diminution des points de vie
            HealthPoints -= damages;
        }

        // Le charactère execute une attaque physique
        public abstract int AttackPhysics();

        // Le charactère execute une attaque magique
        public abstract int AttackMagics();
    }
}