module.exports = {
    name: 'giveitem',
    description: 'Giveitem to player id',
    options: [
        {
            name: 'target',
            description: 'player id',
            required: true,
            type: 'NUMBER',
        },
        {
            name: 'item',
            description: 'itemName',
            required: true,
            type: 'STRING',
        },
        {
            name: 'count',
            description: 'item count',
            required: true,
            type: 'NUMBER',
        },
    ],
    async execute(interaction, client) { 
        await interaction.deferReply({ ephemeral: true });
        const target = interaction.options.getNumber('target');
        const item = interaction.options.getString('item');
        const count = interaction.options.getNumber('count');
        if (checkhasRole(interaction.member)) {
            Giveitem(target, item, count)
            interaction.editReply({content: `${item} has been added to ${target}`, ephemeral:true});
            sendCmlog(interaction.member, target, item, count, 'Giveitem')
        } else {
            interaction.editReply({content: `not have role`, ephemeral:true});
        }

    }
}