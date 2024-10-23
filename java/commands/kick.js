module.exports = {
    name: 'kick',
    description: 'kick from server',
    options: [
        {
            name: 'target',
            description: 'player id',
            required: true,
            type: 'NUMBER',
        },
        {
            name: 'reason',
            description: 'reason for kick',
            required: true,
            type: 'STRING',
        },
    ],
    async execute(interaction, client) { 
        await interaction.deferReply({ ephemeral: false });
        const target = interaction.options.getNumber('target');
        const item = interaction.options.getString('reason');
        if (checkhasRole(interaction.member)) {
        PlayerKick(target, item, interaction.user.username)
        interaction.editReply({content: `id ${target} has been kicked from server, reason ${item}. requested by ${interaction.user}`, ephemeral:false});
        sendCmlog(interaction.member, target, item, 'not', 'Kick')
        } else {
            interaction.editReply({content: `not have role`, ephemeral:true});
        }
    }
}