using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.XPath;

namespace RPG
{
    class Program
    {
        static void Main(string[] args)
        {
            GameText.ChooseNameText();
            var playerName = Console.ReadLine();

            var player = new Player(playerName);
            var monster = new Monster();

            var listOfCharacters = new List<Character>();
            listOfCharacters.Add(player);
            listOfCharacters.Add(monster);

            while (listOfCharacters.All(item => item.IsAlive()))
            {
                GameText.MenuText(player, monster);
                var playerDamages = -1;
                var monsterDamages = 0;

                // Action du joueur
                switch (Console.ReadKey().Key)
                {
                    case ConsoleKey.A:
                        playerDamages = player.AttackPhysics();
                        break;
                    case ConsoleKey.B:
                        playerDamages = player.AttackMagics();
                        break;
                    case ConsoleKey.C:
                        player.UsePotion();
                        break;
                }

                // Attaque du monstre
                monsterDamages = monster.AttackRandom();

                foreach (var c in listOfCharacters)
                {
                    var degats = c.IsPlayer ? playerDamages : monsterDamages;
                    var degatsOpposant = c.IsPlayer ? monsterDamages : playerDamages;

                    if (degats > 0)
                    {
                        GameText.AttackText(c, degats);
                    }
                    else if (degats == 0)
                    {
                        GameText.MissText(c);
                    }
                    else
                    {
                        GameText.UsePotionText(c);
                    }

                    if (degatsOpposant > 0)
                    {
                        c.TakeDamage(degatsOpposant);
                    }
                }
            }

            if (player.IsAlive())
            {
                GameText.WinText();
            }
            else
            {
                GameText.LoseText();
            }
        }
    }
}