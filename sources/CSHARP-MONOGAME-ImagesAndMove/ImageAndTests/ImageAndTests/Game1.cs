using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework.Input;
using System;
using System.Collections.Generic;
using System.IO;

namespace ImageAndTests
{
    public class Jelly
    {
        public Vector2 position;
        public int vitesse;
        public float scaleVitesse;
        public float scale;

        public Jelly(Vector2 pPosition, int pVitesse)
        {
            position = pPosition;
            vitesse = pVitesse;
            scale = 1.0f;
            scaleVitesse = 0.0f - (pVitesse / 100.0f);
        }

        public void UpdatePosition(GameTime gameTime, int maxPositionX)
        {
            position.X += (vitesse * 60.0f) * (float) gameTime.ElapsedGameTime.TotalSeconds;

            if (this.position.X < 0)
            {
                this.position.X = 0;
                this.Inverse();
            }

            if (this.position.X > maxPositionX)
            {
                this.position.X = maxPositionX;
                this.Inverse();
            }
        }

        public void UpdateEffect(GameTime gameTime)
        {
            this.scale += (this.scaleVitesse * 60.0f) * (float) gameTime.ElapsedGameTime.TotalSeconds;
            if (this.scale > 1.0f)
            {
                this.scale = 1.0f;
                this.scaleVitesse = 0 - this.scaleVitesse;
            }

            if (this.scale <= 0.5f)
            {
                this.scale = 0.5f;
                this.scaleVitesse = 0 - this.scaleVitesse;
            }
        }

        public void Inverse()
        {
            vitesse = 0 - vitesse;
        }
    }

    public class Game1 : Game
    {
        private GraphicsDeviceManager _graphics;
        private SpriteBatch _spriteBatch;

        private Texture2D imgSlime;

        private List<Jelly> lstJelly;
        private Random rnd = new Random();

        public Game1()
        {
            _graphics = new GraphicsDeviceManager(this);
            Content.RootDirectory = "Content";
            IsMouseVisible = true;
        }

        protected override void Initialize()
        {
            // TODO: Add your initialization logic here

            base.Initialize();
        }

        protected override void LoadContent()
        {
            _spriteBatch = new SpriteBatch(GraphicsDevice);

            // TODO: use this.Content to load your game content here
            using (var fileStream = new FileStream("../../../Content/slimePurple.png", FileMode.Open))
            {
                imgSlime = Texture2D.FromStream(GraphicsDevice, fileStream);
            }

            lstJelly = new List<Jelly>();

            for (int i = 1; i <= 20; i++)
            {
                int positionX, positionY;
                int vitesse;

                positionX = rnd.Next(0, GraphicsDevice.Viewport.Width - imgSlime.Width);
                positionY = rnd.Next(imgSlime.Height, GraphicsDevice.Viewport.Height);
                vitesse = rnd.Next(1, 10);

                Jelly oJelly = new Jelly(new Vector2(positionX, positionY), vitesse);
                lstJelly.Add(oJelly);
            }
        }

        protected override void Update(GameTime gameTime)
        {
            if (GamePad.GetState(PlayerIndex.One).Buttons.Back == ButtonState.Pressed ||
                Keyboard.GetState().IsKeyDown(Keys.Escape))
                Exit();

            // TODO: Add your update logic here

            foreach (Jelly jelly in lstJelly)
            {
                jelly.UpdatePosition(gameTime, GraphicsDevice.Viewport.Width - imgSlime.Width);
                jelly.UpdateEffect(gameTime);
            }

            base.Update(gameTime);
        }

        protected override void Draw(GameTime gameTime)
        {
            GraphicsDevice.Clear(Color.CornflowerBlue);

            // TODO: Add your drawing code here
            _spriteBatch.Begin();


            foreach (Jelly jelly in lstJelly)
            {
                SpriteEffects effect = jelly.vitesse > 0 ? SpriteEffects.FlipHorizontally : SpriteEffects.None;
                
                _spriteBatch.Draw(imgSlime, jelly.position, null, Color.White, 0, new Vector2(0, imgSlime.Height),
                    new Vector2(1.0f, jelly.scale), effect, 0);
            }

            _spriteBatch.End();

            base.Draw(gameTime);
        }
    }
}