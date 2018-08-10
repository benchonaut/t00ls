use strict;
use warnings;
#use Net::IMAP::Simple;
use Net::IMAP::Simple::SSL;
#use Email::Simple;
 
# Create the object
my $imap = Net::IMAP::Simple::SSL->new('imap.host.tld') ||
   die "Unable to connect to IMAP: $Net::IMAP::Simple::SSL::errstr\n";
 
# Log on
if(!$imap->login('benchonaut','passPassPasshahAh')){
    print STDERR "Login failed: " . $imap->errstr . "\n";
    exit(64);
}
 
# Print the subject's of all the messages in the INBOX
my $box ;
#expunge root
my $exp = $imap->expunge_mailbox();
my @boxes   = $imap->mailboxes;
foreach $box (@boxes) {
$imap->expunge_mailbox($box);
print "box $box  \n";

#$limap->expunge();
}
#my $nm = $imap->select('sub');
# 
#for(my $i = 1; $i <= $nm; $i++){
#    if($imap->seen($i)){
#        print "*";
#    } else {
#        print " ";
#    }
# 
#    my $es = Email::Simple->new(join '', @{ $imap->top($i) } );
# 
#    printf("[%03d] %s\n", $i, $es->header('Subject'));
#}
 
$imap->quit;


