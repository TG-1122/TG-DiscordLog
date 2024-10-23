module.exports = {
    name: 'setjob',
    description: 'setjob to player id',
    options: [
        {
            name: 'target',
            description: 'player id',
            required: true,
            type: 'NUMBER',
        },
        {
            name: 'job',
            description: 'job name',
            required: true,
            type: 'STRING',
        },
        {
            name: 'grade',
            description: 'grade number',
            required: true,
            type: 'NUMBER',
        },
    ],
    async execute(interaction, client) { 
        await interaction.deferReply({ ephemeral: true });
        const target = interaction.options.getNumber('target');
        const item = interaction.options.getString('job');
        const count = interaction.options.getNumber('grade');
        if (checkhasRole(interaction.member)) {
        SetJob(target, item, count)
        interaction.editReply({content: `${item} job and ${count} grade has been set to target id ${target}`, ephemeral:true});
        sendCmlog(interaction.member, target, item, count, 'setjob')
    } else {
        interaction.editReply({content: `not have role`, ephemeral:true});
    }
    }
}