const { MessageEmbed } = require('discord.js');
const jsonfile = require('jsonfile');

const main = GetResourcePath(GetCurrentResourceName());

// Specify the path to the JSON file
const filePath = `${main}/java/logs.json`;

module.exports = {
    name : 'setup-log',
    description: 'to set logs of your fivem server',
    options: [
        {
            name: 'category',
            description: 'The category which need to set log channel',
            type: 'CHANNEL',
            channelTypes: ['GUILD_CATEGORY'],
            required: true,
        }
    ],
    async execute(interaction, client) {
        try {
            const join = '🛬 Join-Logs';
            const leave = '🛫 Leave-Logs';
            const dead = '☠️ Death-Logs';
            const damage = '❤️‍🩹 Damage-Logs';
            const shoot = '🎯 Shooting-Logs';
            const resource = '📁 Resource-Logs';
            const explo = '💣 Explotion-Logs';
            const txadmin = '💻 TxAdmin-Logs';
            const category = interaction.options.getChannel('category');
            await interaction.deferReply({ ephemeral: true });
            let parent;
            if (category) {
              parent = category.id;
            }
            const ajoin = await interaction.guild.channels.create(join,{
                type: 'GUILD_TEXT',
                parent: parent,
              }
            );
            const aleave = await interaction.guild.channels.create(leave,{
                type: 'GUILD_TEXT',
                parent: parent,
              }
            );
            const adead = await interaction.guild.channels.create(dead,{
                type: 'GUILD_TEXT',
                parent: parent,
              }
            );
            const adamage = await interaction.guild.channels.create(damage,{
                type: 'GUILD_TEXT',
                parent: parent,
              }
            );
            const ashoot = await interaction.guild.channels.create(shoot,{
                type: 'GUILD_TEXT',
                parent: parent,
              }
            );
            const aresource = await interaction.guild.channels.create(resource,{
                type: 'GUILD_TEXT',
                parent: parent,
              }
            );

            const aexplo = await interaction.guild.channels.create(explo,{
                type: 'GUILD_TEXT',
                parent: parent,
              }
            );
            const atxadmin = await interaction.guild.channels.create(txadmin,{
                type: 'GUILD_TEXT',
                parent: parent,
              }
            );
            jsonfile.readFile(filePath, (err, jsonData) => {
                if (err) {
                    console.log(err)
                    return;
                }
                jsonData.enable = true;
                jsonData.join = ajoin.id;
                jsonData.leave = aleave.id;
                jsonData.dead = adead.id;
                jsonData.damage = adamage.id;
                jsonData.shoot = ashoot.id;
                jsonData.resource = aresource.id;
                jsonData.explo = aexplo.id;
                jsonData.txadmin = atxadmin.id;
                jsonfile.writeFile(filePath, jsonData, (err) => {
                    if (err) {
                        console.log(err);
                    } else {
                        console.log('JSON file updated successfully!');
                        interaction.editReply({content:`Channel created and please restart server`, ephemeral: true});
                    }
                })
            })
        }catch(error) {
            console.log(error)
        }
    }
}