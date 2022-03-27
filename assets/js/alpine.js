import Alpine from 'alpinejs'
import transactions from './transactions'
import landing from './landing'

Alpine.data('transactions', transactions);
Alpine.data('landing', landing);
document.Alpine = Alpine;
Alpine.start();