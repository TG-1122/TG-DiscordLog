module.exports = {
    name: 'playerdata',
    description: 'Get player data from player id',
    options: [
        {
            name: 'target',
            description: 'player id',
            required: true,
            type: 'NUMBER',
        },
    ],
    async execute(interaction, client) { 
        await interaction.deferReply({ ephemeral: true });
        const target = interaction.options.getNumber('target');
        if (checkhasRole(interaction.member)) {
        const data = GetPlayerData(target)
        const embed = new Discord.MessageEmbed()
        .setTitle('User Information')
        .setDescription(data.join('\n'))
        .setColor('RED')
        .setTimestamp()
        .setThumbnail(interaction.user.displayAvatarURL())
        .setFooter({text:`requested by ${interaction.user.username}`})

        interaction.channel.send({embeds : [embed]})
        interaction.editReply({content: `ID ${target}'s player data`, ephemeral:true});
        sendCmlog(interaction.member, target, 'not', 'not', 'PlayerData')
        } else {
            interaction.editReply({content: `not have role`, ephemeral:true});
        }
    }
}
