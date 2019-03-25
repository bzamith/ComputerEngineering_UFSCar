#pragma once
#include <SFML/Graphics.hpp>
#include<iostream>

bool spriteClick(sf::Sprite &av_Sprite, sf::RenderWindow &av_Window)
{

	int mouseX = sf::Mouse::getPosition().x;
	int mouseY = sf::Mouse::getPosition().y;

	sf::Vector2i windowPosition = av_Window.getPosition();

	if (mouseX > av_Sprite.getPosition().x + windowPosition.x && mouseX < (av_Sprite.getPosition().x + av_Sprite.getGlobalBounds().width + windowPosition.x)
		&& mouseY > av_Sprite.getPosition().y + windowPosition.y + 30 && mouseY < (av_Sprite.getPosition().y + av_Sprite.getGlobalBounds().height + windowPosition.y + 30))
	{
		if (sf::Mouse::isButtonPressed(sf::Mouse::Left))
		{
			return true;
		}
		return false;
	}

	return false;

}