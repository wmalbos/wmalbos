using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;

namespace HorizontalScrollingParallax
{
    public class Background
    {
    
    
        private Vector2 position;
        private Texture2D image;
        private float speed;

        /**
         * Constructeur
         */
        public Background(Texture2D pTexture, float pSpeed)
        {
            image = pTexture;
            speed = pSpeed;
            position = new Vector2(0, 0);
        }

        /**
         * Mise à jours de la position du Background
         */
        public void Update()
        {
            position.X += speed;
            if (position.X <= 0 - image.Width)
            {
                position.X = 0;
            }
        }

        public Vector2 Position
        {
            get { return position; }
        }

        public Texture2D Image
        {
            get { return image; }
        }
    }
}
