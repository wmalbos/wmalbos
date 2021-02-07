using System.IO;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework.Input;

namespace HorizontalScrollingParallax
{
    public class Game1 : Game
    {
        private GraphicsDeviceManager _graphics;
        private SpriteBatch _spriteBatch;

        private Texture2D imgBackground0;
        private Texture2D imgBackground1;
        private Texture2D imgBackground2;
        private Texture2D imgBackground3;

        private Background background0;
        private Background background1;
        private Background background2;
        private Background background3;

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

            using (var fileStream = new FileStream("../../../Content/urban_scrolling0.png", FileMode.Open))
            {
                imgBackground0 = Texture2D.FromStream(GraphicsDevice, fileStream);
            }

            using (var fileStream = new FileStream("../../../Content/urban_scrolling1.png", FileMode.Open))
            {
                imgBackground1 = Texture2D.FromStream(GraphicsDevice, fileStream);
            }

            using (var fileStream = new FileStream("../../../Content/urban_scrolling2.png", FileMode.Open))
            {
                imgBackground2 = Texture2D.FromStream(GraphicsDevice, fileStream);
            }

            using (var fileStream = new FileStream("../../../Content/urban_scrolling3.png", FileMode.Open))
            {
                imgBackground3 = Texture2D.FromStream(GraphicsDevice, fileStream);
            }

            background0 = new Background(imgBackground0, -2);
            background1 = new Background(imgBackground1, -5);
            background2 = new Background(imgBackground2, -8);
            background3 = new Background(imgBackground3, -10);
        }

        protected override void Update(GameTime gameTime)
        {
            if (GamePad.GetState(PlayerIndex.One).Buttons.Back == ButtonState.Pressed ||
                Keyboard.GetState().IsKeyDown(Keys.Escape))
                Exit();

            // TODO: Add your update logic here
            background0.Update();
            background1.Update();
            background2.Update();
            background3.Update();

            base.Update(gameTime);
        }

        protected override void Draw(GameTime gameTime)
        {
            GraphicsDevice.Clear(Color.CornflowerBlue);

            // TODO: Add your drawing code here
            _spriteBatch.Begin();

            PrintBackground(background0);
            PrintBackground(background1);
            PrintBackground(background2);
            PrintBackground(background3);

            _spriteBatch.End();

            base.Draw(gameTime);
        }

        private void PrintBackground(Background pBackground)
        {
            _spriteBatch.Draw(pBackground.Image, pBackground.Position, Color.White);
            if (pBackground.Position.X < 0)
                _spriteBatch.Draw(pBackground.Image, new Vector2(pBackground.Position.X + pBackground.Image.Width, 0),
                    Color.White);
        }
    }
}