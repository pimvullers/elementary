# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.34

inherit meson vala

DESCRIPTION="Switchboard User Accounts Plug."
HOMEPAGE="https://github.com/elementary/switchboard-plug-useraccounts"
SRC_URI="https://github.com/elementary/switchboard-plug-useraccounts/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	>=dev-libs/granite-6.0.0:=
	dev-libs/libgee:0.8
	dev-libs/libpwquality
	gnome-base/gnome-desktop:3=
	>=gui-libs/libhandy-1.1.90:1
	pantheon-base/switchboard
	sys-apps/accountsservice
	>=sys-auth/polkit-0.115
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

src_prepare() {
	eapply_user

	eapply "${FILESDIR}/${PV}-check_paths.patch"
	eapply "${FILESDIR}/${PV}-avatar_icon_check.patch"
	eapply "${FILESDIR}/${PV}-fix_user_lang.patch"
	eapply "${FILESDIR}/${PV}-fix_create_user.patch"

	vala_src_prepare
}

pkg_postinst() {
	if [ ! -d "/etc/lightdm/lightdm.conf.d" ]; then
        mkdir -p "/etc/lightdm/lightdm.conf.d"
    fi
	if [ ! -d "/usr/share/lightdm/lightdm.conf.d/" ]; then
		mkdir -p "/usr/share/lightdm/lightdm.conf.d/"
	fi
	if [ ! -f "/usr/share/lightdm/lightdm.conf.d/60-guest-session.conf" ]; then
		touch "/usr/share/lightdm/lightdm.conf.d/60-guest-session.conf"
	fi
}
