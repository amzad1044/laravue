<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\User as UserResource;
use App\Http\Resources\UserCollection;
use App\Profile;
use App\Role;
use App\User;
use Auth;
use Illuminate\Http\Request;
use Illuminate\Support\Str;



class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $per_page = $request->per_page ? $request->per_page:5;

        $sortBy = $request->sort_by;
        $orderBy = $request->order_by;

        return response()->json([
            'users'=> new UserCollection(User::orderBy($sortBy, $orderBy)->paginate($per_page)), 
            'roles' => Role::pluck('name')->all()],200);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $role = Role::where('name', $request->role)->first();
        $user = new User([
            'name' => $request->name,
            'email' => $request->email,
            'password' => bcrypt($request->password),
        ]);
        $user->role()->associate($role);
        $user->save();
        $user->profile()->save(new Profile());
        return response()->json(['user'=>new UserResource($user)],200);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $users = User::where('name', 'LIKE', "%$id%")->get();
        return response()->json(['users'=> $users],200);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $role = Role::where('name', $request->role)->first();
        $user = User::find($id);

        $LogedInUser = $request->user();
        if($user->id === $LogedInUser->id)
        {
            return response()->json(['user' => new UserResource($LogedInUser)],422);
        }

        $user->name = $request->name;
        $user->role()->dissociate($user->role);
        $user->role()->associate($role);
        $user->save();
        
        return response()->json(['user'=> new UserResource($user)],200);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $user = User::find($id)->delete();
        Profile::where('user_id',$id)->delete();
        return response()->json(['user'=>$user], 200);
    }
    public function deleteAll(Request $request)
    {
        User::whereIn('id',$request->users)->delete();
        return response()->json(['message','Records deleted successfully.'],200);
    }






    public function login(Request $request)
    {
        if($request->ajax())
        {
            $credentials = $request->only('email', 'password');
            if(Auth::attempt($credentials))
            {
                $token = Str::random(80);
                Auth::user()->api_token = $token;
                Auth::user()->save();
                $admin = Auth::user()->isAdmin();
                return response()->json(['token'=>$token,'isAdmin'=> $admin],200);
            }
        }
    	return response()->json(['status'=>'Your information not correct.'],403);

    	
    }
    public function verify(Request $request)
    {
        return $request->user()->only('name','email');
    }

    public function changeRole(Request $request)
    {
        $user = User::find($request->user);
        $LogedInUser = $request->user();
        if($user->id === $LogedInUser->id)
        {
            return response()->json(['user' => new UserResource($LogedInUser)],422);
        }
        $role = Role::where('name', $request->role)->first();
        $user->role()->associate($role);
        $user->save();
        return response()->json(['user'=>new UserResource($user)],200);
    }

    public function changePhoto(Request $request)
    {
        $user = User::find($request->user);
        $profile = Profile::where('user_id', $request->user)->first();
        $ext = $request->photo->extension();
        $photo = $request->photo->storeAs('images', Str::random(20).".{$ext}", 'public');
        $profile->photo = $photo;
        $user->profile()->save($profile);
        return response()->json(['user' => new UserResource($user)],200);
    }

    public function emailVerify(Request $request)
    {
        $request->validate([
            'email' => 'required|unique:users'
        ]);
        return response()->json(['message'=>'Thats Fine'],200);
    }
}
