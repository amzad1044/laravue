<template>
	<v-data-table 
    item-key="name" 
  	class="elevation-1" 
  	:loading = "loading"
  	loading-text="Loading... Please wait"
  	:headers="headers"
    @pagination="paginate"
    :server-items-length="roles.total"
    :items="roles.data"
    :items-per-page=5
    show-select
    @input="selectAll"
    sort-by="calories"
    :footer-props="{
      itemsPerPageOptions:[5,10,25],
      itemsPerPageText:'Total Roles Pages:',
      'show-current-page':true,
      'show-first-last-page':true
    }"
    >
		
		<template v-slot:top>

          <v-col>
              <v-snackbar
                v-model="snackbar"
                right
                color="success"
                :timeout="3000"
              >
                {{ text }}
                <v-btn
                  color="white"
                  text
                  @click="snackbar = false"
                >
                  Close
                </v-btn>
              </v-snackbar>
            </v-col> 

      <v-toolbar flat color="dark">
        <v-toolbar-title>Roles</v-toolbar-title>
        <v-divider
          class="mx-4"
          inset
          vertical
        ></v-divider>
        <v-spacer></v-spacer>
        <v-dialog v-model="dialog" max-width="500px">
          <template v-slot:activator="{ on }">
            <v-btn color="success" dark class="mb-2" v-on="on">Create New</v-btn>
            <v-btn color="error" dark class="mb-2 mr-2" @click="deleteAll">Delete</v-btn>
          </template>


          <v-card>
            <v-card-title>
              <span class="headline">{{ formTitle }}</span>
            </v-card-title>

            <v-card-text>
              <v-container>
                <v-row>
                  <v-col cols="12" sm="12">
                    <v-text-field v-model="editedItem.name" label="Role Name"></v-text-field>
                  </v-col>
                  
                </v-row>
              </v-container>
            </v-card-text>

            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="blue darken-1" text @click="close">Cancel</v-btn>
              <v-btn color="blue darken-1" text @click="save">Save</v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>
      </v-toolbar>
      <v-row>
            <v-col cols="6">
                <v-text-field @input="searchIt" label="Search" class="mx-4"></v-text-field>
            </v-col>
          </v-row>
      
    </template>
    <template v-slot:item.actions="{ item }">
      <v-icon
        small
        class="mr-2"
        @click="editItem(item)"
      >
        mdi-pencil
      </v-icon>
      <v-icon
        small
        @click="deleteItem(item)"
      >
        mdi-delete
      </v-icon>
    </template>


    <template v-slot:no-data>
      <v-btn color="primary" @click="initialize">Reset</v-btn>
    </template>

            

	</v-data-table>
</template>         

</template>
<script>
  export default {
    data: () => ({
      dialog: false,
      loading:false,
      snackbar:false,
      selected:[],
      text:'',
      headers: [
        {text: '#',align: 'left',sortable: false,value: 'id'},
        { text: 'Name', value: 'name' },
        { text: 'Actions', value: 'actions' },
      ],
      roles: [],
      editedIndex: -1,
      editedItem: {
        id:'',
        name: '',
      },
      defaultItem: {
        id:'',
        name: '',
      },
    }),

    computed: {
      formTitle () {
        return this.editedIndex === -1 ? 'New New' : 'Edit Item'
      },
    },

    watch: {
      dialog (val) {
        val || this.close()
      },
    },

    created () {
      this.initialize()
    },

    methods: {
      selectAll(e){
        this.selected=[];
        if(e.length>0)
        {
            this.selected = e.map(val => val.id)
        }
      },
      deleteAll(){
          let decide = confirm('Are you sure you want to delete these items?')
          if(decide)
          {
              axios.post('/api/roles/delete',{'roles':this.selected})
              .then(res=> {
                this.text = "Data Deleted Successfully."
                
                this.selected.map(val =>{
                    const index = this.roles.data.indexOf(val)
                    this.roles.data.splice(index, 1)

                })
                this.snackbar = true
                
              })
              .catch(err=>{
                console.log(err.response)
                this.text = "Error to Deleted."
                this.snackbar = true
              })
          }
      },
      searchIt(e){
        if(e.length > 2){
          axios.get(`/api/roles/${e}`)
              .then(res => this.roles.data = res.data.roles)
              
        }
        if(e.length<=0)
        {
            axios.get(`/api/roles`)
              .then(res => this.roles = res.data.roles)
              .catch(err => console.dir(err.response))
        }
      },
      paginate(e){
          axios.get(`/api/roles?page=${e.page}`,{params:{'per_page':e.itemsPerPage}})
          .then(res=>{
            this.roles = res.data.roles
          })
          .catch( err => {
            if(err.response.status=401)
              localStorage.removeItem('token');
              this.$router.push('/login');
          })
      },  
      initialize () {
          // Add a request interceptor
	      axios.interceptors.request.use((config) => {
	          this.loading = true;
	          return config;
	        },  (error)=> {
	          this.loading = false;
	          return Promise.reject(error);
	        });

	      // Add a response interceptor
	      axios.interceptors.response.use((response) => {
	          this.loading = false;
	          return response;
	        }, (error) => {
	          this.loading = false
	          return Promise.reject(error);
	        });
	      	
      },


      editItem (item) {
        this.editedIndex = this.roles.data.indexOf(item)
        this.editedItem = Object.assign({}, item)
        this.dialog = true
      },

      deleteItem (item) {
        const index = this.roles.data.indexOf(item)
        let decide = confirm('Are you sure you want to delete this item?')
        if(decide)
        {
            axios.delete('/api/roles/'+item.id)
            .then(res=> {
              this.text = "Data Deleted Successfully."
              this.snackbar = true
              this.roles.data.splice(index, 1)
            })
            .catch(err=>{
              console.log(err.response)
              this.text = "Error to Deleted."
              this.snackbar = true
            })
        }

        //confirm('Are you sure you want to delete this item?') && this.roles.splice(index, 1)
      },

      close () {
        this.dialog = false
        setTimeout(() => {
          this.editedItem = Object.assign({}, this.defaultItem)
          this.editedIndex = -1
        }, 300)
      },

      save () {

        if (this.editedIndex > -1) {
          const index = this.editedIndex
          axios.put('/api/roles/'+this.editedItem.id, {'name': this.editedItem.name})
          .then(res => {
            this.text = "Data Updated.";
            this.snackbar = true;
            Object.assign(this.roles.data[index], res.data.role)
          })
          .catch(err => {
            console.log(err.response)
            this.text = "Error!!!"
            this.snackbar = true
          })
          
        } else {
          axios.post('/api/roles',{'name':this.editedItem.name})
          .then(res=> this.roles.data.push(res.data.role))
          .catch(err=>console.log(err.response))
        } 
        this.close()
      },
    },
  }
</script>
<style scoped></style>