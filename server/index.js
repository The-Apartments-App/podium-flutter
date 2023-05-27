import { createClient } from '@supabase/supabase-js'

const supabaseUrl = 'https://dwulrobndxgnknmlcaoi.supabase.co'
const supabaseKey = process.env.SUPABASE_KEY
const supabase = createClient(supabaseUrl, supabaseKey)



async function signInAsDemoUser() {
    const credentials = {
      email: 'demouser@demo.com',
      password: 'password'
    };
  
    try {
      const signInResponse = await supabase.auth.signInWithPassword(credentials);
      return signInResponse;
    } catch (error) {
      console.error('Error signing in:', error.message);
      throw error;
    }
  }