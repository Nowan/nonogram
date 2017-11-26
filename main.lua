local GameModel = require("core.module.model.GameModel");
local GameView = require("core.module.view.GameView");
local GameController = require("core.module.controller.GameController");

local model = GameModel();
local view = GameView();
local controller = GameController(view, model);

local nonogram_data = require("core.data.001");
controller:initGame(nonogram_data);
