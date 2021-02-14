using System;

namespace RPG
{
    public class GameText
    {
        public static void ChooseNameText()
        {
            Console.WriteLine("Choisissez un nom pour votre personnage : ");
        }

        public static void UsePotionText(Character c)
        {
            Console.WriteLine($"{c.Name} a utilisé une potion et a regagné 35 points de vie");
        }

        public static void AttackText(Character c, int damages)
        {
            Console.WriteLine($"{c.Name} attaque pour {damages} points");
        }

        public static void MissText(Character c)
        {
            Console.WriteLine($"{c.Name} a raté son attaque");
        }

        public static void WinText()
        {
            Console.WriteLine("Vous avez gagné !");
        }

        public static void LoseText()
        {
            Console.WriteLine("Vous avez perdu...");
        }

        public static void MenuText(Player player, Monster monster)
        {
            Console.WriteLine($"");
            Console.WriteLine($"{player.Name} : {player.HealthPoints} points de vie - Ennemi : {monster.HealthPoints} points de vie");
            Console.WriteLine($"Choisissez une action : ");
            Console.WriteLine($"a => Attaque physique");
            Console.WriteLine($"b => Attaque magique");
            Console.WriteLine($"c => Utiliser une potion ({player.NumberOfPotions})");
        }
    }
}