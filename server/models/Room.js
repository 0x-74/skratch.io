const mongoose = require('mongoose');
const {playerSchema} = require('./player');
const roomSchema = new mongoose.Schema({
    word: {
        required: true,
        type: String
    },
    roomname: {
        required: true,
        type: String,
        unique: true,
        trim: true

    },
    roomsize: {
        required: true,
        type: Number,
        default: 4
    },
    maxrounds: {
        required: true,
        type: Number,
        default: 1,
    },
    players: [playerSchema],
    isJoin: {
        type: Boolean,
        default: true,
    },
    turn: playerSchema,
    turnIndex: {
        type: Number,
        default: 0
    }
})

const gameModel = mongoose.model('Room',roomSchema);
module.exports = gameModel;