const main = GetResourcePath(GetCurrentResourceName());
const config = require(`${main}/java/config.json`)
const axios = require('axios');

const { Client, Intents, Collection,MessageEmbed } = require('discord.js');

const Discord = require('discord.js')

const ESX = exports['es_extended'].getSharedObject();

const client = new Client({ intents: [Intents.FLAGS.GUILDS, Intents.FLAGS.GUILD_MESSAGES, Intents.FLAGS.GUILD_MEMBERS] });

const commands = new Collection();

const commandFiles = fs.readdirSync(`${main}/java/commands`).filter(file => file.endsWith('.js'));

for (const file of commandFiles) {
  const command = require(`${main}/java/commands/${file}`);
  commands.set(command.name, command);
}

client.on('ready', () => {
    console.log(`Online as user ${client.user.tag} !`)
    console.log('For support join tg-11 Discord Server (https://discord.gg/TuH8tM7mkn)')
    //setInterval(setActivity, 5000)
})

client.on('interactionCreate', async interaction => {
    if (!interaction.isCommand()) return;
    const command = commands.get(interaction.commandName);
    if (!command) return;
    try {
        await command.execute(interaction);
      } catch (error) {
        console.error(`Error executing command: ${error}`);
      }
});

client.login(config.token);

onNet('LogsSender', function(channelu, author, color, tile, msg) {
  //print(channelu, author, color, tile, msg)
  if (msg) {
      const embed = new MessageEmbed()
      .setTitle(tile)
      //.setColor(color)
      .setDescription(msg)
      .setTimestamp()
      .setFooter({text:"A TG-11 Productions"})
      .setAuthor({
          name: author
      });
      const channel = client.channels.cache.get(channelu);
      channel.send({ embeds: [embed] })
  } else {
      const embed = new MessageEmbed()
      .setTitle(tile)
      //.setColor(color)
      .setTimestamp()
      .setFooter({text:"A TG-11 Productions"})
      .setAuthor({
          name: author
      });
      const channel = client.channels.cache.get(channelu);
      channel.send({ embeds: [embed] })
  }
});

function checkhasRole(member) {
  if (member.roles.cache.has('1293986161978511370')) {
      return true
  } else {
      return false
  }
}

function Giveitem(src, item, count) {
  try {
    const xPlayer = ESX.GetPlayerFromId(src)
    if (!xPlayer) {
      console.error(`Player not found with ID ${src}`)
      return null
    }
    xPlayer.addInventoryItem(item, count)
    return true
  } catch (error) {
    console.error(error);
    return null;
  }
}

function GetPlayerData(src) {
  try {
    const xPlayer = ESX.GetPlayerFromId(src)
    if (!xPlayer) {
      console.error(`Player not found with ID ${src}`)
      return null
    }
    const accounts = xPlayer.accounts;
    const blackMoney = accounts.filter(account => account.name === "black_money")[0].money;
    const money = accounts.filter(account => account.name === "money")[0].money;
    const bank = accounts.filter(account => account.name === "bank")[0].money;
    const data = []
    data.push(`**> ID : ${xPlayer.source}**`)
    data.push(`**> Name : ${xPlayer.name}**`)
    data.push(`**> FivemName : ${GetPlayerName(xPlayer.source)}**`)
    data.push(`**> ${xPlayer.license}**`)
    data.push(`**> Group : ${xPlayer.group}**`)
    data.push(`**> Job : ${xPlayer.job.label}**`)
    data.push(`**> Grade : ${xPlayer.job.grade_label}**`)
    data.push(`**> Cash : ${money}**`)
    data.push(`**> Bank : ${bank}**`)
    data.push(`**> Black : ${blackMoney}**`)
    return data
  } catch (error) {
    console.error(error)
    return null
  }
}

function GetInventory(src) {
  try {
    const xPlayer = ESX.GetPlayerFromId(src)
    if (!xPlayer) {
      console.error(`Player not found with ID ${src}`)
      return null
    }
    const data = xPlayer.getInventory()
    const items = Object.keys(data).map(key => {
      let item = data[key];
      return `**> ${item.label} (${item.count}): Weight: ${item.weight} | Slot: ${item.slot}**`;
    });
    const embed = new MessageEmbed()
    .setTitle(`Inventory [${src}]`)
    .setDescription(items.join('\n'))
    .setColor('RED')
    .setTimestamp();
    return embed
  }
  catch (error) {
    console.error(error)
    return null
  }
}

function PlayerKick(src, reason, user) {
  try {
    const xPlayer = ESX.GetPlayerFromId(src)
    if (!xPlayer) {
      console.error(`Player not found with ID ${src}`)
      return null
    }
    xPlayer.kick(`you have been kicked from the server, reason : ${reason} by ${user}`)
    return true
  } catch (error) {
    console.error(error)
    return null
  }
}

function SetJob(src, job, grade) {
  try {
    const xPlayer = ESX.GetPlayerFromId(src)
    if (!xPlayer) {
      console.error(`Player not found with ID ${src}`)
      return null
    }
    xPlayer.setJob(job, grade)
    return true
  } catch (error) {
    console.error(error)
    return null
  }
}

function RemoveMoney(src, type, count) {
  try {
    const xPlayer = ESX.GetPlayerFromId(src)
    if (!xPlayer) {
      console.error(`Player not found with ID ${src}`)
      return null
    }
    xPlayer.removeAccountMoney(type, money)
    return true
  } catch (error) {
    console.error(error)
    return null
  }
}
