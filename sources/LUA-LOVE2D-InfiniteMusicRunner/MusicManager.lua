local newMusicManager = {}

-- Définition de la liste des musiques
newMusicManager.listMusics = {}

-- Définition de la musique de départ
newMusicManager.currentMusic = 0

function newMusicManager.addMusic(_music)

    local newMusic = {}

    newMusic.source = _music
    newMusic.source:setLooping(true)
    newMusic.source:setVolume(0)

    table.insert(newMusicManager.listMusics, newMusic)
end

function newMusicManager.update()

    for index, music in ipairs(newMusicManager.listMusics) do
        if index == newMusicManager.currentMusic then

            if music.source:getVolume() < 1 then
                music.source:setVolume(music.source:getVolume() + 0.01)
            end

        else

            if music.source:getVolume() > 0 then
                music.source:setVolume(music.source:getVolume() - 0.01)
            end
        end
    end
end

function newMusicManager.playMusic(_position)

    local music = newMusicManager.listMusics[_position]

    if music.source:getVolume() == 0 and newMusicManager.currentMusic ~= _position then
        print('La musique '.._position..' débute')
        music.source:play()
    end

    newMusicManager.currentMusic = _position
end

return newMusicManager