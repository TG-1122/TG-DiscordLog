module.exports = {
    name: 'inventorydata',
    description: 'Get player inventory from player id',
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
        const data = GetInventory(target) 

        interaction.channel.send({embeds : [data]})

        interaction.editReply({content: `ID ${target}'s player Inventory`, ephemeral:true});
        sendCmlog(interaction.member, target, 'nil', 'nil', 'Inventory')
        } else {
            interaction.editReply({content: `not have role`, ephemeral:true});
        }
    }
}
