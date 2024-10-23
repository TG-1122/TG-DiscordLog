module.exports = {
    name: 'removemoney',
    description: 'remove money from player id',
    options: [
        {
            name: 'target',
            description: 'player id',
            required: true,
            type: 'NUMBER',
        },
        {
            name: 'type',
            description: 'money, bank and black_money',
            required: true,
            type: 'STRING',
        },
        {
            name: 'money',
            description: 'number',
            required: true,
            type: 'NUMBER',
        },
    ],
    async execute(interaction, client) { 
        await interaction.deferReply({ ephemeral: true });
        const target = interaction.options.getNumber('target');
        const item = interaction.options.getString('type');
        const count = interaction.options.getNumber('money');
        if (checkhasRole(interaction.member)) {
        RemoveMoney(target, item, count)
        interaction.editReply({content: `Rmoved Money of ${count} as ${item} from id ${target}`, ephemeral:true});
        sendCmlog(interaction.member, target, item, count, 'removemoney')
    } else {
        interaction.editReply({content: `not have role`, ephemeral:true});
    }
    }
}