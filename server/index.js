const express = require("express");
var http = require("http");
const app = express();
const port = process.env.PORT || 3000;
var server = http.createServer(app);
const mongoose = require("mongoose");
const Room = require("./models/Room");
const getWord = require('./api/getWord');
var io = require("socket.io")(server);


//middleware
app.use(express.json());
console.log(process.env.mongodb);
const DB = "mongodb+srv://Plasmicz:Aviral123%23%23@skratch.xf3locd.mongodb.net/"

mongoose.connect(DB).then(()=>{
    console.log("Connection was successful");
}).catch((e) => {
    console.log(e);
})

io.on('connection',(socket)=>{
    console.log('connected from '+socket.id);
    socket.on('create-game',async({nickname,roomname,roomsize,maxrounds})=>{
        try{
            const existingRoom = await Room.findOne({roomname});
            if(existingRoom){
                socket.emit('incorrectGame','Room with that name already exists :(');
                return;
            }
            let room = new Room();
            const word = getWord();
            room.word = word;
            room.roomname = roomname;
            room.roomsize = roomsize;
            room.maxrounds = maxrounds;
            

            let player = {
                socketID: socket.id,
                nickname,
                isPartyLeader:true,
            }

            room.players.push(player);
            room = await room.save();
            socket.join(roomname);
            io.to(roomname).emit('updateRoom',room);
        }
        catch(err){
            console.log(err);
        }
    })
    socket.on('join-game',async({nickname,roomname})=>{
        try{
            let room = await Room.findOne({roomname});
            if(!room){
                socket.emit('incorrectGame','the game you are looking for does not exist :P');
                return
            }
            if(room.isJoin){
                let player = {
                    socketID:socket.id,
                    nickname,
                }
                room.players.push(player);
                socket.join(roomname);
            if(room.players.length==room.roomsize){
                room.isJoin=false
            }
            room.turn = room.players[room.turnIndex];
            room = await room.save();
            io.to(roomname).emit('updateRoom',room);
            }
            else{
        socket.emit('incorrectGame','the game you are looking for has started :P');
            }
        }
        catch(err){
            console.log(err);
        }

    })
    socket.on('paint',({details,roomName})=>{
        io.to(roomName).emit('points',{details})
    })
})

server.listen(port,"0.0.0.0",()=>{
    console.log('server has started listening on port: '+port);
})