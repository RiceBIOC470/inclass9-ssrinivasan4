% Inclass assignment 9

% The accession number for human NOTCH1 mRNA is AF308602
% 1. Read the information from this entry into matlab
accession='AF308602';
gb_data=getgenbank(accession);

% 2. Write code that runs a blast query on the first 500 base pairs of this
% gene against the refseq_rna database
seq_begin=gb_data.Sequence(1:500);
[RID, ROTE] = blastncbi(seq_begin, 'blastn', 'Database', 'refseq_rna');
blast_data=getblast(RID, 'WaitTime', ROTE);

% 3. Find the three highest scoring hits from other species and identify
% the length of the alignment and fraction of matches/mismatches.
hit_length = [];
for i=2:4
    blast_data_names=blast_data.Hits(i).Name;
    blast_data_length=blast_data.Hits(i).HSPs.Alignment;
    hit_length=[hit_length length(blast_data_length)];
    disp(["Length of alignment: " int2str(hit_length)])
    blast_data_match=blast_data.Hits(i).HSPs.Identities;
    matches=blast_data_match.Match;
    disp(["Proportion of matches: " num2str(matches/500)])
    disp(["Proportion of mismatches: " num2str((500-matches)/500)])
end
    
% 4. Run the same query against the database est_human. Comment on the
% sequences that you find. 
seq_begin=gb_data.Sequence(1:500);
[RID_est, ROTE_est] = blastncbi(seq_begin, 'blastn', 'Database', 'est_human');
blast_esthuman=getblast(RID_est, 'WaitTime', ROTE);

blast_esthuman.Hits.Name;
%the est database, which is the Expressed Sequence Tags database contains
%single pass cDNA information on a various organisms. By limiting it to
%human, we see closest hits of cDNA that expressed in humans only.